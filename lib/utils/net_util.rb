require 'net/https'
require 'active_support'

class NetUtil
  READ_TIMEOUT = 600 # 10 minutes
  RETRY_TIMES = 3
  WAIT_TIME = 5 # Wait for 5 seconds before retry
  
  
  # This method performs GET, PUT and POST requests to web services
  # Call it like this:
  # response = NetUtil.call_web_services(url)  <= This will perform a GET, with url provided by the caller
  # response = NetUtil.call_web_services(url, 'post', doc) <= This will perform a POST, doc is the data to post, can be REXML::Document or XML String
  # In the case of GET,  the returned XML data is 'response'
  # In the case of POST and PUT, the returned XML data is 'response.body'
  def NetUtil.call_webservices(url, method_name = 'get', data = '', options = { headers: {'Content-Type' => 'application/json'} })
    method_name = method_name.to_s.downcase
    try_time = 0
    begin
      NetUtil.send("do_#{method_name}", {url: url, data: data}.merge(options))
    rescue StandardError => error
      try_time += 1
      if try_time > RETRY_TIMES
        puts ("\n#{Time.now} Unrecoverable error in NetUtil.call_webservices: "\
                                   "#{error}\n#{error.backtrace.join("\n")}\n")
        # It is an unrecoverable error, throw the exception back, don't suppress it.
        raise "Unrecoverable error calling web services.\nURL: #{url}.\nError message: #{error.message}." 
      end
      
      puts ("NetUtil.call_webservices #{url}:\nError happens: #{error}. Try #{try_time} time(s).")
      sleep(WAIT_TIME)
      retry
    end
  end
  
  def NetUtil.do_get(options)
    # headers   = {'Content-Type' => 'text/xml'}
    headers   = build_header(options)
    puts "headers = #{headers.inspect}"
    url       = options[:url]
    uri       = URI.parse(url)
    req       = Net::HTTP.new(uri.host, uri.port)
    req = set_ssl(req, url)
    
    response = req.get(uri.path)
    return response.body
  end
  
  def NetUtil.do_post(options)
    run_p(options, 'post')
  end
  
  def NetUtil.do_put(options)
    run_p(options, 'put')
  end
  
  
  def NetUtil.run_p(options, method_name)
    data = options[:data].to_s
    
    headers   = build_header(options)
    url       = options[:url]
    uri       = URI.parse(url)
    req       = Net::HTTP.new(uri.host, uri.port)
    req       = set_ssl(req, url)
    
    req.read_timeout  = READ_TIMEOUT
    req.open_timeout  = READ_TIMEOUT
    
    response, body   = req.send(method_name, uri.path, data, headers)
    
    return response
  end
  
  def NetUtil.build_header(options)
    headers = options[:headers] || { 'Content-Type' => 'application/json' }
    conntent_type = ( headers['Content-Type'].nil? )? 'application/json' : headers['Content-Type']
    headers.delete('Content-Type')

    {'Content-Type' => conntent_type}.merge(headers)
  end

  def NetUtil.set_ssl(request, url)
    if url.start_with? 'https'
      request.use_ssl = true 
      request.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    request
  end
end



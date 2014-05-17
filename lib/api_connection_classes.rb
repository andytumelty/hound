require 'httparty'
require 'json'

APPLICATION_NAME = "TruffleHound/0.1 (andrew.tumelty@gmail.com)"

class Wikipedia
  include HTTParty
  base_uri 'en.wikipedia.org/w/api.php'

  def get_body(titles)
    @options = { :query => { format: 'json',
                             action: 'query',
                             prop: 'revisions',
                             rvprop: 'content',
                             titles: titles,
                             redirects: '' },
                 :headers => { "User-Agent" => APPLICATION_NAME }}
    self.class.get('',@options)
  end

  def get_links(titles,continue,plcontinue)
    @options = { :query => { format: 'json',
                             action: 'query',
                             prop: 'links',
                             titles: titles,
                             continue: continue,
                             redirects: '' },
                 :headers => { "User-Agent" => APPLICATION_NAME }}
    if !plcontinue.nil?
      @options[:query][:plcontinue] = plcontinue
    end
    self.class.get('',@options)
  end

  def get_ext_links(titles,continue,eloffset)
    @options = { :query => { format: 'json',
                             action: 'query',
                             prop: 'extlinks',
                             titles: titles,
                             continue: continue,
                             redirects: '' },
                 :headers => { "User-Agent" => APPLICATION_NAME }}
    if !eloffset.nil?
      @options[:query][:eloffset] = eloffset
    end
    self.class.get('',@options)
  end
end

class Imdb
  include HTTParty
  base_uri 'http://www.omdbapi.com/'

  def get_with_id(id)
    @options = { :query => { i: id,
                             tomatoes: true },
                 :headers => { "User-Agent" => APPLICATION_NAME }}
    self.class.get('',@options)
  end
end
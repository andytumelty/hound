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
                             titles: titles, },
                 :headers => { "User-Agent" => APPLICATION_NAME }}
    self.class.get('',@options)
  end

  def get_links(titles,continue,plcontinue)
    @options = { :query => { format: 'json',
                             action: 'query',
                             prop: 'links',
                             titles: titles,
                             continue: continue },
                 :headers => { "User-Agent" => APPLICATION_NAME }}
    if !plcontinue.nil?
      @options[:query][:plcontinue] = plcontinue
    end
    self.class.get('',@options)
  end
end

def get_wiki_film_link_list
  wiki = Wikipedia.new
  titles =  "List of films: numbers|"\
            "List of films: A|"\
            "List of films: B|"\
            "List of films: C|"\
            "List of films: D|"\
            "List of films: E|"\
            "List of films: F|"\
            "List of films: G|"\
            "List of films: H|"\
            "List of films: I|"\
            "List of films: J–K|"\
            "List of films: L|"\
            "List of films: M|"\
            "List of films: N–O|"\
            "List of films: P|"\
            "List of films: Q–R|"\
            "List of films: S|"\
            "List of films: T|"\
            "List of films: U–W|"\
            "List of films: X–Z"
  links = []
  result = {'continue' => {'continue' => nil, 'plcontinue' => nil}}

  begin
    puts "#{result['continue']['continue']}, #{result['continue']['plcontinue']}"
    response = wiki.get_links(titles,result['continue']['continue'],result['continue']['plcontinue'])
    result = JSON.parse(response.body)
    result['query']['pages'].each do |page|
      if page[1].has_key?('links')
        links += page[1]['links']
      end
    end
  end while result.has_key?('continue')
  links = links.uniq
  File.open("wiki_film_links_list.yml", "w") do |file|
    file.write links.to_yaml
  end
  return links
end

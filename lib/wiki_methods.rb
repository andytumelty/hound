require 'yaml'
require 'sqlite3'
require 'awesome_print'
require 'date'

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

def get_wiki_film_data
  db = SQLite3::Database.new("data.db")
  wiki = Wikipedia.new
  links = YAML.load_file('./wiki_film_links_list.yml')
  total_links = links.count
  i = 1
  start = Time.now
  links.each do |link|
    print "[#{i}/#{total_links}] #{link['title']} ... "
    response = wiki.get_body(link['title'])
    result = JSON.parse(response.body)
    response['query']['pages'].each do |page|
      if page[0] == "-1" # if the page doesn't exist the id will be set as -1
        db.execute( "insert into movies (name) values(?);",link['title'])
      else
        if text = page[1]['revisions'][0]['*']
          if !text.scan(/{{Infobox Film/i).empty? # is the page a movie?
            result = {'continue' => {'continue' => nil, 'eloffset' => nil}}
            titles = link['title']
            extlinks = ""
            begin
              response = wiki.get_ext_links(titles,result['continue']['continue'],result['continue']['eloffset'])
              result = JSON.parse(response.body)
              result['query']['pages'].each do |page|
                if page[1].has_key?('extlinks')
                  page[1]['extlinks'].each do |extlink|
                    extlinks += "#{extlink['*']}\n"
                  end
                end
              end
            end while result.has_key?('continue')
            #name = text.scan(/{{.*?Infobox film.*?\n.*?\|*?.*?name.*?=\s*(.*?)(?:\||\n)+/i)
            name = link['title']
            imdb_id = extlinks.scan(/imdb.com\/title\/(.*)\/\n/)
            rt_link_title = extlinks.scan(/rottentomatoes.com\/m\/(.*)\/\n/)
            if !imdb_id.empty?
              imdb_id = imdb_id[0][0]
            end
            if !rt_link_title.empty?
              rt_link_title = rt_link_title[0][0]
            end
            #print "VARS: #{name}, #{imdb_id}, #{rt_link_title} "
            db.execute( "insert into movies (name, wiki_page_title, imdb_id, rt_link_title) values(?,?,?,?);",
                        [name, link['title'], imdb_id, rt_link_title])
          end
        end
      end
    end
    print "[ETA] #{Time.now+((Time.now-start)*(total_links/i))}\n"
    i += 1
  end
  return nil
  puts "DONE Start: #{start}, End: #{Time.now}"
end
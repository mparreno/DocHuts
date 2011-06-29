require 'hpricot'
require 'fileutils'
require 'rake'

namespace :kml do
    desc "Import a KML file"
    task :import => :environment do
        filename = ENV['filename'].to_s 

        filehandle = File.open(filename, 'r')
        kml = Hpricot(filehandle)

        places = (kml/"document/Folder/Placemark")
        puts "File: #{(kml/"document/Folder/name").inner_html} \n\n"
        puts "Preparing to import #{places.length} records \n\n"
        import_counter = 0
        places.each do |placemark|
          h = Hut.new
          points = []
          h.name = (placemark/"name").inner_html
          h.description = (placemark/"description").inner_html
          
          coordinates = (placemark/"//coordinates").inner_html
          points_arr = coordinates.to_s.strip.split(",")
          points.push Point.new(:longitude => points_arr[0].to_f, :latitude => points_arr[1].to_f)

           
           if h.valid?
             h.save!
             points.each do |p|
               if p.valid?
                 p.hut = h
                 p.save!
               end
             end       
             import_counter = import_counter + 1
             puts ". Hut #{import_counter}"
           else
             puts "x"
           end
        end
        
        puts "Successfully imported #{import_counter} of #{places.length} records\n"
        
        filehandle.close     
    end
  
end
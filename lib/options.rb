require 'optparse'

class Options
	def parse(args)
		# declare defaults
		options = {:targetdir => "site/", :sourcedir => "images/", :thumbnaildir => "tn/", :file_pattern => ["*.jpg"],
							 :tn_width => 200, :tn_height => 150, :img_width => 940, :img_height => 705, :images_per_page => 16,
							 :author => ""}

		#set up options parser
		opt_parser = OptionParser.new do |opts|
			opts.banner = "Usage: pictr.rb -T <title> [options]"
			opts.separator ""
			opts.separator "available options:"

			opts.on("-T", "--title TITLE", "title of the gallery to produce") {|title|
				options[:title] = title
			}

			opts.on("-t", "--target-dir DIR", "directory in which pictr should store the generated files (default: site/)") { |dir|
				options[:targetdir] = dir
			}

			opts.on("-s", "--source-dir DIR", "directory from which pictr reads your pictures (default: images/)") { |dir|
				options[:sourcedir] = dir
			}

			opts.on("-a", "--author AUTHOR", "Name of the author/creator of the pictures (default: <empty>)") { |author|
				options[:author] = author
			}

			opts.on("-p", "--pattern PATTERN", Array, "Comma separated file patterns for scanning input directory for picture files (default: '*.jpg')") { |pattern|
				options[:file_pattern] = pattern
			}

			opts.on("--thumbnail-width WIDTH", Integer, "width of the generated thumbnail (default: 200px)") { |width|
				options[:tn_width] = width
			}

			opts.on("--thumbnail-height HEIGHT", Integer, "height of the generated thumbnail (default: 150px)") { |height|
				options[:tn_height] = height
			}

			opts.on("--image-width WIDTH", Integer, "width of the generated image (default: 940px)") { |width|
				options[:image_width] = width
			}

			opts.on("--image-height HEIGHT", Integer, "height of the generated image (default: 705px)") { |height|
				options[:image_height] = height
			}

			opts.on("--images-per-page IMAGES", Integer, "number of images per page (default: 16)") { |images|
				options[:images_per_page] = images
			}

 			opts.on_tail("-h", "-?", "--help", "Show this message") do
				puts opts
				exit
			end

			opts.on_tail("--version", "Show version") do
				puts "pictr #{Pictr::VERSION}"
        exit
			end
		end
		
		# parse given arguments, handle errors
		begin
			opt_parser.parse! args
		rescue OptionParser::InvalidOption => e
			warn e.message
			abort opt_parser.to_s
		end
		# check for title switch
		if options[:title].nil?
			puts "Option 'title' missing: must be given\n\n"
			puts opt_parser	
			exit
  	end      
		#return options hash
		options
	end
end

require 'optparse'

class Options
	def parse(args)
		# declare defaults
		options = {:targetdir => "site/", :sourcedir => "images/", :thumbnaildir => "tn/", :file_pattern => "*.jpg",
							 :tn_width => 200, :tn_height => 200, :img_width => 940, :img_height => 705}

		#set up options parser
		opt_parser = OptionParser.new do |opts|
			opts.banner = "Usage: example.rb [options]"
			opts.separator ""
			opts.separator "available options:"

			opts.on("-t", "--target-dir DIR", "directory in which pictr should store the generated files (default: site/)") { |dir|
				options[:targetdir] = dir
			}

			opts.on("-s", "--source-dir DIR", "directory from which pictr reads your pictures (default: images/)") { |dir|
				options[:sourcedir] = dir
			}

			opts.on("-p", "--pattern PATTERN", Array, "Comma separated file patterns for scanning input directory for picture files (default: '*.jpg')") { |pattern|
				options[:file_pattern] = pattern
			}

			opts.on("--thumbnail-width WIDTH", Integer, "width of the generated thumbnail (default: 200px)") { |width|
				options[:tn_width] = width
			}

			opts.on("--thumbnail-height HEIGHT", Integer, "height of the generated thumbnail (default: 200px)") { |height|
				options[:tn_height] = height
			}

			opts.on("--image-width WIDTH", Integer, "width of the generated image (default: 940px)") { |width|
				options[:image_width] = width
			}

			opts.on("--image-height HEIGHT", Integer, "height of the generated image (default: 705px)") { |height|
				options[:image_height] = height
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
		#return options hash
		options
	end
end

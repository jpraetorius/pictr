class Img

	attr_accessor :file_name, :image_name, :thumbnail_name, :caption, :long_caption, :image_link

	def initialize(filename, options)
		@file_name = filename
		@options = options
		base_name = File.basename(filename)	
		@image_link = base_name
		@image_name = @options[:targetdir] + base_name
		@thumbnail_name = @options[:targetdir] + 'tn/' + base_name.split('.')[0] + '_tn.' + base_name.split('.')[1]
	end

	# Only convert Files that are not already around. For that see if the converted files exist in targetdirectory
	def converted?
		File.exists?(@image_name) && File.exists?(@thumbnail_name)
	end

	def convert
		process_image
		@thumb.write @thumbnail_name
		@image.write @image_name
	end
	
	def get_binding
		binding
	end

	private
	
	def process_image
		@image = Image.read @file_name
		@image = @image.first
		@thumb = @image.resize_to_fit(@options[:tn_width], options[:tn_height])
		@image = @image.resize_to_fit(options[:image_width], options[:image_height])
		make_caption
	end

	def make_caption
		d = Date.parse(@image.get_exif_by_entry('DateTime')[0][1])
		date = d.strftime('%d.%m.%Y')
		exposure = @image.get_exif_by_entry('ExposureTime')[0][1] + 's'
		focal_length = @image.get_exif_by_entry('FocalLength')[0][1].split('/')[0] + 'mm'
		f_number = 'F' + @image.get_exif_by_entry('FNumber')[0][1].split('/')[0]
		if (@image.iptc_profile)
			@image.format = 'iptc'
			binstring = @image.to_blob
			asciistring = binstring.unpack('C*')
			marker = asciistring.index(120)
			length_1 = asciistring[marker+1].to_i
			length_2 = asciistring[marker+2].to_i
			length = length_1 + length_2
			@caption = binstring[marker+3,length] #+3 excludes the marker byte and the two following length bytes
			@long_caption = "#{date} | #{exposure} | #{focal_length}  | #{f_number} | #{@caption}"
		else
			@long_caption = "#{date} | #{exposure} | #{focal_length}  | #{f_number}"
		end
	end
end


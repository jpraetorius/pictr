class Img

	attr_accessor :file_name, :image_name, :thumbnail_name, :caption, :long_caption, :image_html_name, :page_html_name, :prev_img, :next_img

	def initialize(filename, previmg, nextimg, options)
		@file_name = filename
		@prev_img = File.basename(previmg).split('.')[0] + '.html' unless previmg.nil?
		@next_img = File.basename(nextimg).split('.')[0] + '.html' unless nextimg.nil?
		@options = options
		base_name = File.basename(filename)
		name_parts = base_name.split('.')
		@image_name = base_name
		@thumbnail_name = name_parts[0] + '_tn.' + name_parts[1]
		@image_html_name = name_parts[0] + ".html"
	end

	def image_filename
		File.join(@options[:image_dir], @image_name)
	end

	def thumbnail_filename
		File.join(@options[:thumbnail_dir], @thumbnail_name)
	end

	def first_image?
		@prev_img.nil?
	end

	def last_image?
		@next_img.nil?
	end

	# Only convert Files that are not already around. For that see if the converted files exist in targetdirectory
	def converted?
		File.exists?(image_filename) && File.exists?(thumbnail_filename)
	end
 	
	def convert
		process_image
		@thumb.write thumbnail_filename
		@image.write image_filename
	end
	
	def get_binding
		binding
	end

	private
	
	def process_image
		@image = Image.read @file_name
		@image = @image.first
		@thumb = @image.resize_to_fit(@options[:tn_width], @options[:tn_height])
		@image = @image.resize_to_fit(@options[:img_width], @options[:img_height])
		make_caption
	end

	def make_caption
		d = Date.parse(@image.get_exif_by_entry('DateTime')[0][1])
		date = d.strftime('%d.%m.%Y')
		exposure = @image.get_exif_by_entry('ExposureTime')[0][1] + 's'
		focal_length = @image.get_exif_by_entry('FocalLength')[0][1].split('/')[0] + 'mm'
		f_number = 'F' + @image.get_exif_by_entry('FNumber')[0][1].split('/')[0]
		img = IPTC::JPEG::Image.from_file(@file_name,false)
		cap = img.values["iptc/Caption"]
		@caption = cap.nil? ? @image_name : cap.value[0]
		@long_caption = "#{date} | #{exposure} | #{focal_length}  | #{f_number} | #{@caption}"
	end
end


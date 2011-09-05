class Page

	attr_accessor :page_html_name, :images, :page_num, :total_number_of_pages

	def initialize(options)
		@options = options
		@images = []
	end

	def add_image(image)
		@images << image
	end

  def filled?
		@images.length == @options[:images_per_page]
	end

	def first_page?
		@page_num == 0
	end

	def last_page?
		@page_num == @total_number_of_pages
	end

	def prev_page
		@page_num if first_page?
		@page_num-1
	end

	def next_page
		@page_num if last_page?
		@page_num+1
	end

	def render_page(page_num, total_num_of_pages)
		@page_num = page_num
		@total_number_of_pages = total_num_of_pages
		@page_html_name = "%04d" % @page_num + ".html" # 9999 Pages should be enough for everybody
		render_images
		page_template = ERB.new(File.new("templates/page.erb").read)
		content = page_template.result(self.get_binding)	
		f = File.new(@options[:targetdir] + @page_html_name, "w+")
		f.write content
		f.close
	end

	def render_images
		img_template = ERB.new(File.new("templates/image.erb").read)
		@images.each do |image|
			if !image.converted?
				image.convert
				image.page_html_name = @page_html_name
				content = img_template.result(image.get_binding)
				f = File.new(@options[:targetdir] + image.image_html_name, "w+")
				f.write content
				f.close
			end
		end
	end

	def get_binding
		binding
	end
	
end


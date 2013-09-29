class Startpage

	def initialize(options)
		@options = options
		@thumbs = []
		@num_thumbs = 6
		@start_picture = ""
	end

	def render_page()
		@page_html_name = "index.html" # So it automatically gets served by all HTTP Servers
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


# require general dependencies
require 'date'
require 'erb'
include ERB::Util
require 'fileutils'
require 'iptc'
require 'RMagick'
include Magick

#require internal classes
require './lib/img.rb'
require './lib/options.rb'
require './lib/page.rb'

class Pictr

	VERSION = "0.8.1"

	attr_accessor :pages

	def initialize(options)
		@options = options 
		@pages = []
	end

	def convert
		check_directories
		read_pictures
		pagenum = @pages.length
		@pages.each_with_index do |page, index|
			page.render_page(index, pagenum)
		end
		# copy static contents
		files = Dir.glob('static/*')
		FileUtils.cp_r files, @options[:targetdir]
	end

	private
	def check_directories
		@options[:thumbnail_dir] = @options[:targetdir] + 'tn/'
		@options[:image_dir] = @options[:targetdir] #keep those the same at the moment
		Dir.mkdir(@options[:targetdir]) unless Dir.exists?(@options[:targetdir])
		Dir.mkdir(@options[:thumbnail_dir]) unless Dir.exists?(@options[:thumbnail_dir])
	end

	def read_pictures
		imgnames = []
		page = Page.new(@options)
		@options[:file_pattern].each do |pattern|
			files = Dir.glob(@options[:sourcedir] + pattern) 
			imgnames += files
		end
		# kinda hackish approach to propagating the number of images
		@options[:total_number_of_pictures] = imgnames.length
		[nil, *imgnames, nil].each_cons(3) do |previmg, imagename, nextimg|
			if page.filled?
				@pages.push page
				page = Page.new(@options)
			end
			page.add_image Img.new(imagename, previmg, nextimg, @options)
		end
		@pages.push page # push last page irregardless of filling status
	end
end

#main script
options = Options.new
opt = options.parse ARGV
pictr = Pictr.new opt
pictr.convert

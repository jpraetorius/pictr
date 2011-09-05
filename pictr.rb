# require general dependencies
require 'date'
require 'erb'
require 'fileutils'
require 'RMagick'
include Magick

#require internal classes
require './lib/img.rb'
require './lib/options.rb'
require './lib/page.rb'

class Pictr

	VERSION = "0.8.1"

	attr_accessor :pages, :targetdir

	def initialize(options)
		puts options
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
		#files = Dir.glob('static/*')
		#FileUtils.cp_r files, @targetdir
	end

	private
	def check_directories
		Dir.mkdir(@options[:targetdir]) unless Dir.exists?(@options[:targetdir])
		Dir.mkdir(@options[:targetdir] + 'tn/') unless Dir.exists?(@options[:targetdir] + 'tn/')
	end

	def read_pictures
		imgnames = []
		page = Page.new(@options)
		@options[:file_pattern].each do |pattern|
			files = Dir.glob(@options[:sourcedir] + pattern) 
			imgnames += files
		end
		imgnames.each do |imagename|
			if page.filled?
				@pages.push page
				page = Page.new
			end
			page.add_image Img.new(imagename, @options)
		end
		@pages.push page # push last page irregardless of filling status
	end
end

#main script
options = Options.new
opt = options.parse ARGV
pictr = Pictr.new opt
pictr.convert

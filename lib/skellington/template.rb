module Skellington
  class Template
    attr_reader :name
    attr_accessor :params, :outpath

    def initialize name
      @name = name
      @outpath = name
    end

    def templates_dir
      File.join File.dirname(__FILE__), '..', 'templates'
    end

    def template name, params = {}
      t = File.read(File.open("#{templates_dir}/#{name}.eruby"))
      FileUtils.mkdir_p("#{@path}/#{File.dirname name}")
      f = File.open "#{@path}/#{name}", 'w'
      f.write Erubis::Eruby.new(t).result(params)
      f.close
    end

    def write
      FileUtils.mkdir_p File.dirname @outpath
      f = File.open @outpath, 'w'
      f.write self
      f.close
    end

    def to_s
      t = File.read(File.open("#{templates_dir}/#{@name}.eruby"))
      Erubis::Eruby.new(t).result(@params)
    end
  end
end

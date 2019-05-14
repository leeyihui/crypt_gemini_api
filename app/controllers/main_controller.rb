class MainController < ApplicationController
  def index
    @symbols = ApiGemini.new.symbols
  end
end

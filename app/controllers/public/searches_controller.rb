class Public::SearchesController < ApplicationController
  def search_sns
  end

  def search_review
  end

  def search_cafe
    @area = params[:area]
    @key_word = params[:key_word]
    @cafes = Cafe.search_for(@area, @key_word)
  end
end

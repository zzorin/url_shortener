class UrlsController < ApplicationController
  include Shortener::ShortenerHelper
  def create
    if params[:url]
      url = Shortener::ShortenedUrl.generate(params[:url])
      render json: { short_url: short_url(url.url) }
    else
      render json: { error: 'Укажите ссылку в параметре :url' }
    end
  end

  def show
    token = ::Shortener::ShortenedUrl.extract_token(params[:id])
    url = ::Shortener::ShortenedUrl.fetch_with_token(token: token, additional_params: params, track: true)
    render json: { url: url[:url] }
  end

  def stats
    token = ::Shortener::ShortenedUrl.extract_token(params[:id])
    url = ::Shortener::ShortenedUrl.fetch_with_token(token: token, additional_params: params, track: false)
    if url[:shortened_url]
      render json: { count: url[:shortened_url][:use_count] }
    else
      render json: { error: 'Статистика для ссылки не найдена' }
    end
  end
end

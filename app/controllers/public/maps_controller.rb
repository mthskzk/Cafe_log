class Public::MapsController < ApplicationController
  def index
    if params[:area] == "全国"
      @area = params[:area]
      # areaの検索フォームが空のときは日本の中心の緯度経度を設定
      gon.lat = 37.592850
      gon.lag = 139.273600
      # 地図の拡大度を設定
      gon.zoom = 5
    else
      @area = params[:area]
      # 検索された地域の緯度経度を設定
      address = Geocoder.search(@area)
      gon.lat = address.first.coordinates[0]
      gon.lag = address.first.coordinates[1]
      # 地図の拡大度を設定
      gon.zoom = 13
    end
    gon.caves = Cafe.all
  end
end

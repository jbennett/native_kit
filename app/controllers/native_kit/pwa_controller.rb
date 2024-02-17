class NativeKit::PwaController < ApplicationController
  skip_forgery_protection

  def manifest
    render "manifest", layout: false
  end
end

class NativeKit::PwaController < ApplicationController
  skip_forgery_protection

  def manifest
    render "manifest", layout: false
  end

  def service_worker
    if use_pipeline?
      send_file get_full_path_to_asset("service_worker.js"), disposition: :inline
    else
      render "service_worker", layout: false
    end
  end

  private

  def use_pipeline?
    true  # TODO: use config to toggle asset pipeline
  end

  def get_full_path_to_asset(filename)
    manifest_file = Rails.application.assets_manifest.assets[filename]
    if manifest_file
      File.join(Rails.application.assets_manifest.directory, manifest_file)
    else
      Rails.application.assets&.[](filename)&.filename
    end
  end
end

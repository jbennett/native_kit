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
    if defined?(Propshaft)
      propshaft_path(filename)
    else
      sprockets_path(filename)
    end
  end

  def propshaft_path(filename)
    if Rails.application.assets.resolver.is_a? Propshaft::Resolver::Static
      File.join(Rails.root, "public", Rails.application.assets.resolver.resolve(filename))
    else
      Rails.application.assets.resolver.load_path.find("service_worker.js").path
    end
  end

  def sprockets_path(filename)
    manifest_file = Rails.application.assets_manifest.assets[filename]
    if manifest_file
      File.join(Rails.application.assets_manifest.directory, manifest_file)
    else
      Rails.application.assets&.[](filename)&.filename
    end
  end
end

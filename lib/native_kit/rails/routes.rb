module ActionDispatch::Routing
  class Mapper
    def mount_native_kit(path = "/native_kit", skip_service_worker: false, skip_webmanifest: false)
      mount NativeKit::Engine => path

      get "manifest" => "native_kit/pwa#manifest" unless skip_webmanifest
    end
  end
end

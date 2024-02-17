module ActionDispatch::Routing
  class Mapper
    def mount_native_kit(path = "/native_kit", skip_service_worker: false, skip_webmanifest: false)
      mount NativeKit::Engine => path

      get "service_worker" => "native_kit/pwa#service_worker" unless skip_service_worker
      get "manifest" => "native_kit/pwa#manifest" unless skip_webmanifest
    end
  end
end

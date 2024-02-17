# TODO: why are you not autoloading ???
require_relative "../../app/helpers/native_kit/application_helper"
require_relative "rails/routes"

module NativeKit
  class Engine < ::Rails::Engine
    isolate_namespace NativeKit

    ActiveSupport.on_load(:action_view) do
      include NativeKit::ApplicationHelper
    end
  end
end

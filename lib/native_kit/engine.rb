require_relative "rails/routes"

module NativeKit
  class Engine < ::Rails::Engine
    isolate_namespace NativeKit

    initializer "native_kit.action_view" do
      ActiveSupport::Reloader.to_prepare do
        ActionView::Base.include ::NativeKit::ApplicationHelper
      end
    end
  end
end

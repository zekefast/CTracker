RSpec.shared_examples "controller does not respond to actions" do |actions|
  actions.each do |name, method|
    it "does not respond to #{method.to_s.upcase} :#{name}" do
      expect { send(method, name) }.to raise_error(ActionController::UrlGenerationError)
    end
  end
end

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      admin = create(:admin, email: "test@test.cl", password: "SuPaP4S5wurD!", password_confirmation: "SuPaP4S5wurD!")
      sign_in admin
    end
  end
end

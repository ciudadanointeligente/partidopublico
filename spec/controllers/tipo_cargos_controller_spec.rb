require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe TipoCargosController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # TipoCargo. As you add validations to TipoCargo, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TipoCargosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all tipo_cargos as @tipo_cargos" do
      tipo_cargo = TipoCargo.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:tipo_cargos)).to eq([tipo_cargo])
    end
  end

  describe "GET #show" do
    it "assigns the requested tipo_cargo as @tipo_cargo" do
      tipo_cargo = TipoCargo.create! valid_attributes
      get :show, {:id => tipo_cargo.to_param}, valid_session
      expect(assigns(:tipo_cargo)).to eq(tipo_cargo)
    end
  end

  describe "GET #new" do
    login_admin
    it "assigns a new tipo_cargo as @tipo_cargo" do
      get :new, {}, valid_session
      expect(assigns(:tipo_cargo)).to be_a_new(TipoCargo)
    end
  end

  describe "GET #edit" do
    login_admin
    it "assigns the requested tipo_cargo as @tipo_cargo" do
      tipo_cargo = TipoCargo.create! valid_attributes
      get :edit, {:id => tipo_cargo.to_param}, valid_session
      expect(assigns(:tipo_cargo)).to eq(tipo_cargo)
    end
  end

  describe "POST #create" do
    login_admin
    context "with valid params" do
      it "creates a new TipoCargo" do
        expect {
          post :create, {:tipo_cargo => valid_attributes}, valid_session
        }.to change(TipoCargo, :count).by(1)
      end

      it "assigns a newly created tipo_cargo as @tipo_cargo" do
        post :create, {:tipo_cargo => valid_attributes}, valid_session
        expect(assigns(:tipo_cargo)).to be_a(TipoCargo)
        expect(assigns(:tipo_cargo)).to be_persisted
      end

      it "redirects to the created tipo_cargo" do
        post :create, {:tipo_cargo => valid_attributes}, valid_session
        expect(response).to redirect_to(TipoCargo.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved tipo_cargo as @tipo_cargo" do
        post :create, {:tipo_cargo => invalid_attributes}, valid_session
        expect(assigns(:tipo_cargo)).to be_a_new(TipoCargo)
      end

      it "re-renders the 'new' template" do
        post :create, {:tipo_cargo => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    login_admin
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested tipo_cargo" do
        tipo_cargo = TipoCargo.create! valid_attributes
        put :update, {:id => tipo_cargo.to_param, :tipo_cargo => new_attributes}, valid_session
        tipo_cargo.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested tipo_cargo as @tipo_cargo" do
        tipo_cargo = TipoCargo.create! valid_attributes
        put :update, {:id => tipo_cargo.to_param, :tipo_cargo => valid_attributes}, valid_session
        expect(assigns(:tipo_cargo)).to eq(tipo_cargo)
      end

      it "redirects to the tipo_cargo" do
        tipo_cargo = TipoCargo.create! valid_attributes
        put :update, {:id => tipo_cargo.to_param, :tipo_cargo => valid_attributes}, valid_session
        expect(response).to redirect_to(tipo_cargo)
      end
    end

    context "with invalid params" do
      it "assigns the tipo_cargo as @tipo_cargo" do
        tipo_cargo = TipoCargo.create! valid_attributes
        put :update, {:id => tipo_cargo.to_param, :tipo_cargo => invalid_attributes}, valid_session
        expect(assigns(:tipo_cargo)).to eq(tipo_cargo)
      end

      it "re-renders the 'edit' template" do
        tipo_cargo = TipoCargo.create! valid_attributes
        put :update, {:id => tipo_cargo.to_param, :tipo_cargo => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    login_admin
    it "destroys the requested tipo_cargo" do
      tipo_cargo = TipoCargo.create! valid_attributes
      expect {
        delete :destroy, {:id => tipo_cargo.to_param}, valid_session
      }.to change(TipoCargo, :count).by(-1)
    end

    it "redirects to the tipo_cargos list" do
      tipo_cargo = TipoCargo.create! valid_attributes
      delete :destroy, {:id => tipo_cargo.to_param}, valid_session
      expect(response).to redirect_to(tipo_cargos_url)
    end
  end

end

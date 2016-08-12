module Features
  module HelperMethods
    def given_logged_in_as(user)
      visit "/usuarios/ingresa"
      fill_in("Correo electrónico", :with => user.email)
      fill_in("Contraseña", :with => user.password)
      click_on("ENTRAR")
    end

    def given_organization_with_catalog
      create(:inventory, organization: @user.organization)
      create(:catalog, :datasets, organization: @user.organization)
    end

    def given_organization_with_opening_plan
      create(:catalog, :datasets, organization: @user.organization)
    end

    def sees_success_message(message)
      within(".toast-success") do
        expect(page).to have_text(message)
      end
    end

    def sees_error_message(message)
      within first(".toast-error") do
        expect(page).to have_text(message)
      end
    end

    def activity_log_created_with_msg(message)
      @activity = ActivityLog.last
      expect(@activity).not_to be_nil
      expect(@activity.description).to eq(message)
    end

    def generate_new_opening_plan
      visit new_opening_plan_path
      fill_in 'catalog_datasets_attributes_0_description', with: 'osom dataset'
      select('anual', from: 'catalog[datasets_attributes][0][accrual_periodicity]')
      click_on('Guardar Plan de Apertura')
    end

    def given_organization_has_catalog_with(datasets)
      create :inventory, organization: @user.organization
      create :opening_plan, organization: @user.organization
      create :catalog, datasets: datasets, organization: @user.organization
      @user.organization.reload
    end

    def resource_checkbox
      find("input[type='checkbox']")
    end

    def checkboxes
      all("input[type='checkbox']")
    end

    def set_rows
      all('table tbody tr.dataset')
    end

    def set_row
      set_rows.first
    end

    def resource_rows
      all('table tbody tr.distribution')
    end
  end
end

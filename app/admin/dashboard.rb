ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Recent Targets' do
          table_for Target.order('id desc').limit(10) do
            column('Title')     { |t| link_to(t.title, admin_target_path(t)) }
            column('Topic')     { |t| t.topic.to_s }
          end
        end
      end

      column do
        panel 'Recent Contacts' do
          table_for ContactAdmin.order('id desc').limit(10) do
            column('User')     { |t| link_to(t.email, admin_contact_admin_path(t)) }
            column('Message')  { |t| t.message.truncate(50) }
          end
        end
      end
    end
  end
end

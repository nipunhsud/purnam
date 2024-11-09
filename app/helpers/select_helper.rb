module SelectHelper
  def roles_options(selected_role: nil)
    options_for_select(ProjectCollaborator.roles.keys.map { |role| [role.humanize, role] }, selected_role)
  end

  def accounts_options(accounts:, selected_account_id: nil)
    options_for_select(accounts.collect { |account| [account.full_name, account.id] }, selected_account_id)
  end
end

module CustomAssertions
  def assert_permit(account, record, action)
    msg = "Account #{account.inspect} should be permitted to #{action} #{record}, but isn't permitted"

    assert Pundit.policy!(account, record).public_send(action), msg
  end

  def refute_permit(account, record, action)
    msg = "Account #{account.inspect} should NOT be permitted to #{action} #{record}, but is permitted"

    assert_not Pundit.policy!(account, record).public_send(action), msg
  end
end

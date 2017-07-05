RbacCore::PermissionSet.draw do
  group :project do
    permission :create
    permission :destroy
    permission :edit
  end

  group :task do
    permission :create
    permission :destroy
    permission :edit_my_own
  end
end

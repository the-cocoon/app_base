class AttachedFile < ActiveRecord::Base
  include ::TheStorages::AttachedFile
  include ::Notifications::LocalizedErrors
end
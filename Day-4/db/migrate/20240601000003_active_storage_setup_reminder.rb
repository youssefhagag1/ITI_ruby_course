# Active Storage is set up via:
#   bin/rails active_storage:install
#   bin/rails db:migrate
#
# That creates the three Active Storage tables automatically.
# This migration is a reminder / placeholder only.
class ActiveStorageSetupReminder < ActiveRecord::Migration[8.0]
  def change
    # Run:  bin/rails active_storage:install && bin/rails db:migrate
    # This creates active_storage_blobs, active_storage_attachments,
    # and active_storage_variant_records tables.
  end
end

# app/models/article.rb
class Article < ApplicationRecord
  belongs_to :user

  # Active Storage – attach one image per article
  has_one_attached :image

  # ── Scopes ──────────────────────────────────────────────────────────────────
  scope :published, -> { where(status: "published") }
  scope :archived,  -> { where(status: "archived") }

  # ── Validations ─────────────────────────────────────────────────────────────
  validates :title,  presence: true, length: { minimum: 3 }
  validates :body,   presence: true
  validates :status, inclusion: { in: %w[published archived] }

  # ── Callback: auto-archive when reports_count reaches 3 ────────────────────
  after_update :archive_if_over_reported

  # ── Instance helpers ────────────────────────────────────────────────────────
  def published?
    status == "published"
  end

  def archived?
    status == "archived"
  end

  # Increment reports and save
  def increment_reports!
    increment!(:reports_count)
  end

  private

  def archive_if_over_reported
    # Triggered by the after_update callback after reports_count is saved
    if reports_count >= 3 && status != "archived"
      update_columns(status: "archived")
    end
  end
end

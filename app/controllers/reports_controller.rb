class ReportsController < ApplicationController
  before_action :authenticate_user!

  expose(:subject_items) { SubjectItem.includes(:teacher, :students) }
end

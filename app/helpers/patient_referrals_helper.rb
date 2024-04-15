# frozen_string_literal: true

module PatientReferralsHelper
  def importances_for_select
    @importances_for_select ||= PatientReferral.importances.keys
  end
end

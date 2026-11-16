# X12278FollowUpActionCodes (X12 889 only) and X12278ReviewDecisionReasonCode (X12 886 only) cannot be checked,
# because the X12 code systems are not available to the validator. Like the other X12-only PAS value sets, their
# membership errors are suppressed in the v2.2.1 suites, and only theirs.
RSpec.describe DaVinciPASTestKit do # rubocop:disable RSpec/SpecFilePathFormat
  def suppressed?(message)
    DaVinciPASTestKit::V221_SUPPRESSED_MESSAGES.match?(
      message.sub(DaVinciPASTestKit::VALIDATOR_MESSAGE_LOCATION_PREFIX, '')
    )
  end

  def membership_message(name, value_set, codes)
    'ClaimResponse/synthetic-response: ClaimResponse.error[0].extension[0].value.ofType(CodeableConcept): ' \
      "None of the codings provided are in the value set '#{name}' " \
      "(http://hl7.org/fhir/us/davinci-pas/ValueSet/#{value_set}|2.2.1), and a coding from this value set is " \
      "required) (codes = #{codes})"
  end

  it 'suppresses the membership error for an X12 889 follow up action code' do
    expect(suppressed?(membership_message('X12 278 Follow Up Action Value Set', 'X12278FollowUpActionCodes',
                                          'https://codesystem.x12.org/005010/889#C'))).to be true
  end

  it 'suppresses the membership error for an X12 886 review decision reason code' do
    expect(suppressed?(membership_message('X12 278 Review Decision Reason Code Value Set',
                                          'X12278ReviewDecisionReasonCode',
                                          'https://codesystem.x12.org/external/886#01'))).to be true
  end

  it 'still reports the membership error for another PAS value set' do
    expect(suppressed?(membership_message('PAS Supporting Info Type', 'PASSupportingInfoType',
                                          'http://example.org/codes#x'))).to be false
  end
end

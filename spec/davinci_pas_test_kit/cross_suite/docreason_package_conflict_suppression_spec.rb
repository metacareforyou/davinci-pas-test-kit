# PAS 2.2.1 -> CDex 2.1.0 -> DTR 2.1.0 -> CRD 2.1.0 is loaded beside CRD 2.2.1. The unversioned DTR intendedUse
# extension then resolves to DTR 2.1.0's binding (DocReason 2.1.0), while codes resolve under CRD 2.2.1, so no
# coding passes. The suppression hides only that message, for a CRD 2.2.1 DocReason code.
RSpec.describe DaVinciPASTestKit do # rubocop:disable RSpec/SpecFilePathFormat
  def suppressed?(message)
    DaVinciPASTestKit::V221_SUPPRESSED_MESSAGES.match?(
      message.sub(DaVinciPASTestKit::VALIDATOR_MESSAGE_LOCATION_PREFIX, '')
    )
  end

  def docreason_message(codes)
    'QuestionnaireResponse/synthetic-answers: QuestionnaireResponse.extension[1].value.ofType(CodeableConcept): ' \
      "None of the codings provided are in the value set 'CRD Coverage Information Documentation Reason Value Set' " \
      '(http://hl7.org/fhir/us/davinci-crd/ValueSet/DocReason|2.1.0), and a coding from this value set is required) ' \
      "(codes = #{codes})"
  end

  it 'suppresses the DocReason 2.1.0 binding error for a CRD 2.2.1 coverage-information-codes withpa coding' do
    expect(suppressed?(docreason_message('http://hl7.org/fhir/us/davinci-crd/CodeSystem/coverage-information-codes#withpa')))
      .to be true
  end

  it 'does not suppress it for a code that is not a DocReason code' do
    expect(suppressed?(docreason_message('http://hl7.org/fhir/us/davinci-crd/CodeSystem/coverage-information-codes#covered')))
      .to be false
  end

  it 'does not suppress it for a coding from another code system' do
    expect(suppressed?(docreason_message('http://example.org/codes#withpa'))).to be false
  end

  it 'does not suppress the binding error against DocReason 2.2.1' do
    message = docreason_message('http://example.org/codes#withpa').sub('DocReason|2.1.0', 'DocReason|2.2.1')
    expect(suppressed?(message)).to be false
  end
end

require_relative '../telemetry'

describe TelemetryDiagnostics do
  context "#initialize" do
    it "when the TelemetryDiagnostics is initialized, it has a diagnostic_info that is an empty string" do
      expect(TelemetryDiagnostics.new.diagnostic_info).to eq ""
    end
  end

  describe "#diagnostic_info" do
    context "when the connection fails" do
      it "raises an exception" do
        mock_telemetry_client = double("TelemetryClient", disconnect: nil, online_status: false, online_status: false, connect: nil)
        allow(TelemetryClient).to receive(:new).and_return(mock_telemetry_client)

        telemetry_diagnostics = TelemetryDiagnostics.new
        
        expect{telemetry_diagnostics.check_transmission}.to raise_error
      end
    end

    context "when the connection succeeds" do
      it "saves response to diagnostic info" do
        response = "foo"
        mock_telemetry_client = double("TelemetryClient", disconnect: nil, online_status: true, connect: nil, TelemetryClient::DIAGNOSTIC_MESSAGE => nil, receive: response)
        allow(TelemetryClient).to receive(:new).and_return(mock_telemetry_client)
        telemetry_diagnostics = TelemetryDiagnostics.new

        telemetry_diagnostics.check_transmission

        expect(telemetry_diagnostics.diagnostic_info).to eq(response)
      end
    end

    # before we  check_transmission
    xit "returns the correct diagnostic info" do
      expect(TelemetryDiagnostics.new.diagnostic_info).to eq ""
    end

    # after we check_transmission
    xit "returns the correct diagnostic info" do
      telemetry_diagnostics = TelemetryDiagnostics.new
      telemetry_diagnostics.check_transmission
      
      expect(telemetry_diagnostics.diagnostic_info).to eq ""
    end
  end
end

# WHAT DOES THE GIVEN CODE DO
# REQ 1:  if connection fails raise error -  
# REQ 2:  if connection succeeds it saves the response to diagnostic_info




# Context: when initailized  XX
#   it has a diagnostic_info that is an empty string

# Context: when the connection fails XX
#   it raises an exception

# Context: when the connection is successful

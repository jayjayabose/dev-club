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


# Context: when initailized  XX
#   it has a diagnostic_info that is an empty string

# Context: when the connection fails <<
#   it raises an exception

# Context: when the connection is successful

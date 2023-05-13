class LuggageModel {
  String id;
  String pnrId;
  String checkInPlace;
  String checkInTime;
  String loadingPlace;
  String loadingTime;
  String unloadingPlace;
  String unloadingTime;
  String checkoutPlace;
  String checkoutTime;
  String status;
  String checkInStaffName;
  String loadingStaffName;
  String unloadingStaffName;
  String checkOutStaffName;
  String checkInStatus;
  String loadingStatus;
  String unloadingStatus;
  String checkOutStatus;
  String missingPlace;

  LuggageModel(
      this.id,
      this.pnrId,
      this.checkInPlace,
      this.checkInTime,
      this.loadingPlace,
      this.loadingTime,
      this.unloadingPlace,
      this.unloadingTime,
      this.checkoutPlace,
      this.checkoutTime,
      this.status,
      this.checkInStaffName,
      this.loadingStaffName,
      this.unloadingStaffName,
      this.checkOutStaffName,
      this.checkInStatus,
      this.loadingStatus,
      this.unloadingStatus,
      this.checkOutStatus,
      this.missingPlace,
      );
}
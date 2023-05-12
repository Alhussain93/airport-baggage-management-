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
  );
}

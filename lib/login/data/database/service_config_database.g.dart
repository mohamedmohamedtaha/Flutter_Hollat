// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_config_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceConfigDatabaseAdapter extends TypeAdapter<ServiceConfigDatabase> {
  @override
  final int typeId = 0;

  @override
  ServiceConfigDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceConfigDatabase()
      ..id = (fields[0] as num).toInt()
      ..agentAddTicketsWithSameCriteria = fields[1] as String
      ..amplitudeEnabled = fields[2] as String
      ..beneficiaryMaxTicketsPerDay = fields[3] as String
      ..beneficiaryMaxTicketsPerDayPerOrg = fields[4] as String
      ..birthDateHijri = fields[5] as String
      ..chatBotEnabled = fields[6] as String
      ..chatBotSrcUrl = fields[7] as String
      ..mainSiteURl = fields[8] as String
      ..smallImage = fields[9] as String
      ..clientName = fields[10] as String
      ..clientNameAr = fields[11] as String
      ..email = fields[12] as String
      ..slaSolvingTime = fields[13] as String
      ..unifiedNumber = fields[14] as String
      ..workingHours = fields[15] as String
      ..uploadFilesFromSelfService = fields[16] as String
      ..feedbackExpiredTimeInDays = fields[17] as String
      ..selfServiceLoginEnabled = fields[18] as String
      ..selfServiceLoginWithMobile = fields[19] as String
      ..selfServiceLoginWithNationalId = fields[20] as String
      ..selfServiceLoginWay = fields[21] as String
      ..maintenanceMode = fields[22] as String
      ..minCharsOnDetails = fields[23] as String
      ..mobileDefaultCountry = fields[24] as String
      ..nafathEnabled = fields[25] as String
      ..rateConfigId = fields[26] as String
      ..selfServiceAddTicketWithSameCriteria = fields[27] as String
      ..selfServiceAfterFeedbackMessageAr = fields[28] as String
      ..selfServiceAfterFeedbackMessageEn = fields[29] as String
      ..selfServiceClientCanChangeStatus = fields[30] as String
      ..selfServiceOtpBy = fields[31] as String
      ..selfServiceShowTerms = fields[32] as String
      ..selfServiceSimilarTicket = fields[33] as String
      ..selfServiceTermsContent = fields[34] as String
      ..showNoCaseAtRating = fields[35] as String
      ..facebookUrl = fields[36] as String
      ..instagramUrl = fields[37] as String
      ..linkedinUrl = fields[38] as String
      ..snapChatUrl = fields[39] as String
      ..tiktokUrl = fields[40] as String
      ..twitterUrl = fields[41] as String
      ..youtubeURl = fields[42] as String
      ..selfServiceFeedbackQuestionnaire = fields[43] as String
      ..selfServiceHospitalID = fields[44] as String
      ..selfServiceOTPEnabled = fields[45] as String
      ..selfServiceOTPExpirationTimePerMin = fields[46] as String
      ..selfServiceBackgroundImage = fields[47] as String
      ..selfServiceContactUsDisplay = fields[48] as String
      ..selfServiceEnabled = fields[49] as String
      ..selfServiceKBDisplay = fields[50] as String
      ..copyRightAr = fields[51] as String
      ..copyRightEn = fields[52] as String
      ..copyRightUrl = fields[53] as String
      ..favIcon = fields[54] as String
      ..headerColor = fields[55] as String
      ..headerHoverColor = fields[56] as String
      ..largeLogo = fields[57] as String
      ..smallLogo = fields[58] as String
      ..primaryColor = fields[59] as String
      ..selfServiceDisplayFontAr = fields[60] as String
      ..selfServiceDisplayFontEn = fields[61] as String
      ..backgroundImage = fields[62] as String
      ..verifyMobileAfterLoginWithEmail = fields[63] as String;
  }

  @override
  void write(BinaryWriter writer, ServiceConfigDatabase obj) {
    writer
      ..writeByte(64)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.agentAddTicketsWithSameCriteria)
      ..writeByte(2)
      ..write(obj.amplitudeEnabled)
      ..writeByte(3)
      ..write(obj.beneficiaryMaxTicketsPerDay)
      ..writeByte(4)
      ..write(obj.beneficiaryMaxTicketsPerDayPerOrg)
      ..writeByte(5)
      ..write(obj.birthDateHijri)
      ..writeByte(6)
      ..write(obj.chatBotEnabled)
      ..writeByte(7)
      ..write(obj.chatBotSrcUrl)
      ..writeByte(8)
      ..write(obj.mainSiteURl)
      ..writeByte(9)
      ..write(obj.smallImage)
      ..writeByte(10)
      ..write(obj.clientName)
      ..writeByte(11)
      ..write(obj.clientNameAr)
      ..writeByte(12)
      ..write(obj.email)
      ..writeByte(13)
      ..write(obj.slaSolvingTime)
      ..writeByte(14)
      ..write(obj.unifiedNumber)
      ..writeByte(15)
      ..write(obj.workingHours)
      ..writeByte(16)
      ..write(obj.uploadFilesFromSelfService)
      ..writeByte(17)
      ..write(obj.feedbackExpiredTimeInDays)
      ..writeByte(18)
      ..write(obj.selfServiceLoginEnabled)
      ..writeByte(19)
      ..write(obj.selfServiceLoginWithMobile)
      ..writeByte(20)
      ..write(obj.selfServiceLoginWithNationalId)
      ..writeByte(21)
      ..write(obj.selfServiceLoginWay)
      ..writeByte(22)
      ..write(obj.maintenanceMode)
      ..writeByte(23)
      ..write(obj.minCharsOnDetails)
      ..writeByte(24)
      ..write(obj.mobileDefaultCountry)
      ..writeByte(25)
      ..write(obj.nafathEnabled)
      ..writeByte(26)
      ..write(obj.rateConfigId)
      ..writeByte(27)
      ..write(obj.selfServiceAddTicketWithSameCriteria)
      ..writeByte(28)
      ..write(obj.selfServiceAfterFeedbackMessageAr)
      ..writeByte(29)
      ..write(obj.selfServiceAfterFeedbackMessageEn)
      ..writeByte(30)
      ..write(obj.selfServiceClientCanChangeStatus)
      ..writeByte(31)
      ..write(obj.selfServiceOtpBy)
      ..writeByte(32)
      ..write(obj.selfServiceShowTerms)
      ..writeByte(33)
      ..write(obj.selfServiceSimilarTicket)
      ..writeByte(34)
      ..write(obj.selfServiceTermsContent)
      ..writeByte(35)
      ..write(obj.showNoCaseAtRating)
      ..writeByte(36)
      ..write(obj.facebookUrl)
      ..writeByte(37)
      ..write(obj.instagramUrl)
      ..writeByte(38)
      ..write(obj.linkedinUrl)
      ..writeByte(39)
      ..write(obj.snapChatUrl)
      ..writeByte(40)
      ..write(obj.tiktokUrl)
      ..writeByte(41)
      ..write(obj.twitterUrl)
      ..writeByte(42)
      ..write(obj.youtubeURl)
      ..writeByte(43)
      ..write(obj.selfServiceFeedbackQuestionnaire)
      ..writeByte(44)
      ..write(obj.selfServiceHospitalID)
      ..writeByte(45)
      ..write(obj.selfServiceOTPEnabled)
      ..writeByte(46)
      ..write(obj.selfServiceOTPExpirationTimePerMin)
      ..writeByte(47)
      ..write(obj.selfServiceBackgroundImage)
      ..writeByte(48)
      ..write(obj.selfServiceContactUsDisplay)
      ..writeByte(49)
      ..write(obj.selfServiceEnabled)
      ..writeByte(50)
      ..write(obj.selfServiceKBDisplay)
      ..writeByte(51)
      ..write(obj.copyRightAr)
      ..writeByte(52)
      ..write(obj.copyRightEn)
      ..writeByte(53)
      ..write(obj.copyRightUrl)
      ..writeByte(54)
      ..write(obj.favIcon)
      ..writeByte(55)
      ..write(obj.headerColor)
      ..writeByte(56)
      ..write(obj.headerHoverColor)
      ..writeByte(57)
      ..write(obj.largeLogo)
      ..writeByte(58)
      ..write(obj.smallLogo)
      ..writeByte(59)
      ..write(obj.primaryColor)
      ..writeByte(60)
      ..write(obj.selfServiceDisplayFontAr)
      ..writeByte(61)
      ..write(obj.selfServiceDisplayFontEn)
      ..writeByte(62)
      ..write(obj.backgroundImage)
      ..writeByte(63)
      ..write(obj.verifyMobileAfterLoginWithEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceConfigDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

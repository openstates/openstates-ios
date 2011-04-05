//
//  TexLegeLibrary.m
//  TexLege
//
//  Created by Gregory Combs on 2/4/11.
//  Copyright 2011 Gregory S. Combs. All rights reserved.
//

#import "TexLegeLibrary.h"
#import "UtilityMethods.h"

NSString *stringForChamber(NSInteger chamber, TLStringReturnType type) {
	NSString *chamberString = nil;
	
	if (type == TLReturnFull) {
		switch (chamber) {
			case HOUSE:
				chamberString = @"House";
				break;
			case SENATE:
				chamberString = @"Senate";
				break;
			case JOINT:
				chamberString = @"Joint";
				break;
			case BOTH_CHAMBERS:
			default:
				chamberString = @"All";
				break;
		}
	}
	else if (type == TLReturnInitial) {
		switch (chamber) {
			case SENATE:
				chamberString = @"(S)";
				break;
			case HOUSE:
				chamberString = @"(H)";
				break;
			case JOINT:
				chamberString = @"(J)";
				break;
			case BOTH_CHAMBERS:
			default:
				chamberString = @"(All)";
				break;
		}	
	}
	else if (type == TLReturnAbbrev) {
		switch (chamber) {
			case SENATE:
				chamberString = @"Sen.";
				break;
			case HOUSE:
				chamberString = @"Rep.";
				break;
			case BOTH_CHAMBERS:
			case JOINT:
				chamberString = @"Jnt.";
				break;
			default:
				chamberString = @"";
		}
		
	}
	else if (type == TLReturnOpenStates) {
		switch (chamber) {
			case SENATE:
				chamberString = @"upper";
				break;
			case HOUSE:
				chamberString = @"lower";
				break;
			case JOINT:
				chamberString = @"joint";
				break;
			case BOTH_CHAMBERS:
			default:
				chamberString = @"";
		}
	}
	
	return chamberString;
}

NSInteger chamberForString(NSString *chamberString) {
	if (!chamberString)
		return BOTH_CHAMBERS;
	
	if ([chamberString isEqualToString:@"upper"] ||
		[chamberString isEqualToString:@"Sen."] ||
		[chamberString isEqualToString:@"(S)"] ||
		[chamberString isEqualToString:@"Senate"])
		return SENATE;
	else if ([chamberString isEqualToString:@"lower"] ||
			 [chamberString isEqualToString:@"Rep."] ||
			 [chamberString isEqualToString:@"(R)"] ||
			 [chamberString isEqualToString:@"House"])
		return HOUSE;
	else if ([chamberString isEqualToString:@"joint"] ||
			 [chamberString isEqualToString:@"Jnt."] ||
			 [chamberString isEqualToString:@"(J)"] ||
			 [chamberString isEqualToString:@"Joint"])
		return JOINT;
	else
		return BOTH_CHAMBERS;
}



NSString *stringForParty(NSInteger party, TLStringReturnType type) {
	NSString *partyString = nil;
	
	if (type == TLReturnFull) {
		switch (party) {
			case DEMOCRAT:
				partyString = @"Democrat";
				break;
			case REPUBLICAN:
				partyString = @"Republican";
				break;
			default:
				partyString = @"Independent";
				break;
		}		
	}
	if (type == TLReturnInitial) {
		switch (party) {
			case DEMOCRAT:
				partyString = @"D";
				break;
			case REPUBLICAN:
				partyString = @"R";
				break;
			default:
				partyString = @"I";
				break;
		}
	}
	if (type == TLReturnAbbrev) {
		switch (party) {
			case DEMOCRAT:
				partyString = @"Dem.";
				break;
			case REPUBLICAN:
				partyString = @"Rep.";
				break;
			default:
				partyString = @"Ind.";
				break;
		}
	}
	return partyString;
}

NSString *billTypeStringFromBillID(NSString *billID) {
	NSArray *words = [billID componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	if (!IsEmpty(words))
		return [words objectAtIndex:0];
	else
		return nil;
}

BOOL billTypeRequiresOpposingChamber(NSString *billType) {
	BOOL requires = YES;
	if (!IsEmpty(billType)) {
		if (([billType isEqualToString:@"HR"]) || 
			([billType isEqualToString:@"SR"]))
			requires = NO;
	}
	return requires;
}

BOOL billTypeRequiresGovernor(NSString *billType) {
	BOOL requires = billTypeRequiresOpposingChamber(billType);
	if (!IsEmpty(billType)) {
		if (([billType hasSuffix:@"JR"]) ||
			([billType hasSuffix:@"CR"]))	// shouldn't this be TRUE though?
			requires = NO;
	}
	return requires;
}

NSString * watchIDForBill(NSDictionary *aBill) {
	if (aBill && [aBill objectForKey:@"session"] && [aBill objectForKey:@"bill_id"])
		return [NSString stringWithFormat:@"%@:%@", [aBill objectForKey:@"session"],[aBill objectForKey:@"bill_id"]]; 
	else
		return @"";
}



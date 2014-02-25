//
//  NSDate+GCKit.m
//  GCKit
//
//  Created by Gustavo Cassab on 31/03/11.
//  Copyright 2011 GCCore Digital Technologies. All rights reserved.
//

#import "NSDate+GCKit.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (GCKit)

+ (NSDate *)today {
	return [NSDate date];
}

+ (NSTimeInterval)secondsPerDay {
	NSTimeInterval secondsPerDay = 24 * 60 * 60;
	return secondsPerDay;
}

+ (NSDate *)tomorrow {
	NSDate *date = [NSDate date];
	NSDate *tomorrow = [date dateByAddingTimeInterval:[NSDate secondsPerDay]];
	return tomorrow;
}

+ (NSDate *)afterTomorrow {
	NSDate *date = [NSDate date];
	NSDate *afterTomorrow = [date dateByAddingTimeInterval:([NSDate secondsPerDay] *2)];
	return afterTomorrow;
}

+ (NSDate *)yesterday {
	NSDate *date = [NSDate date];
	NSDate *yesterday = [date dateByAddingTimeInterval:-[NSDate secondsPerDay]];
	return yesterday;
}

+ (NSDate *)beforeYesterday {
	NSDate *date = [NSDate date];
	NSDate *beforeYesterday = [date dateByAddingTimeInterval:-([NSDate secondsPerDay] *2)];
	return beforeYesterday;
}

+ (NSDate *)lastDateOfThisMonth {
	NSRange daysRange = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate date]];
	NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
	[comp setDay:daysRange.length];
	NSDate *endOfMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];
	return endOfMonth;
}

+ (BOOL)date:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate {
    return (([date compare:beginDate] != NSOrderedAscending) && ([date compare:endDate] != NSOrderedDescending));
}

+ (NSDate *)dateFromString:(NSString *)aStringDate withFormat:(NSString *)aFormat withLocale:(NSString *)aLocale {
	
	NSDate *date;
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
	// Define timezone
	[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
	if (aLocale) {
		[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:aLocale]];
	} else {
		[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
	}
    
	if (aFormat) {
		[dateFormatter setDateFormat:aFormat];
	} else {
		[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
	}
	
	date = [dateFormatter dateFromString:aStringDate];
	
	return date;
}

+ (NSDate *)todayMinusDays:(NSUInteger)days {
	NSDate *date = [NSDate date];
	NSDate *minusDaysDate = [date dateByAddingTimeInterval:-([NSDate secondsPerDay] *days)];
	return minusDaysDate;
}

+ (NSDate *)todayPlusDays:(NSUInteger)days {
	NSDate *date = [NSDate date];
	NSDate *plusDaysDate = [date dateByAddingTimeInterval:([NSDate secondsPerDay] *days)];
	return plusDaysDate;
}

#pragma mark Relative Dates

+ (NSDate *)dateWithDaysFromNow: (NSInteger) days {
	return [[NSDate date] dateByAddingDays:days];
}

+ (NSDate *)dateWithDaysBeforeNow: (NSInteger) days {
	return [[NSDate date] dateBySubtractingDays:days];
}

+ (NSDate *)dateTomorrow {
	return [NSDate dateWithDaysFromNow:1];
}

+ (NSDate *)dateYesterday {
	return [NSDate dateWithDaysBeforeNow:1];
}

+ (NSDate *)dateWithHoursFromNow:(NSInteger)dHours {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)dateWithHoursBeforeNow:(NSInteger)dHours {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)dateWithMinutesFromNow:(NSInteger)dMinutes {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

+ (NSDate *)dateWithMinutesBeforeNow:(NSInteger)dMinutes {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSString *)monthName {
	NSUInteger m = [self month];
	NSString *r;
	switch (m) {
		case  1: { r = NSLocalizedString(@"Janeiro", @"");   break; }
		case  2: { r = NSLocalizedString(@"Fevereiro", @""); break; }
		case  3: { r = NSLocalizedString(@"Março", @"");     break; }
		case  4: { r = NSLocalizedString(@"Abril", @"");     break; }
		case  5: { r = NSLocalizedString(@"Maio", @"");      break; }
		case  6: { r = NSLocalizedString(@"Junho", @"");     break; }
		case  7: { r = NSLocalizedString(@"Julho", @"");     break; }
		case  8: { r = NSLocalizedString(@"Agosto", @"");    break; }
		case  9: { r = NSLocalizedString(@"Setembro", @"");  break; }
		case 10: { r = NSLocalizedString(@"Outubro", @"");   break; }
		case 11: { r = NSLocalizedString(@"Novembro", @"");  break; }
		case 12: { r = NSLocalizedString(@"Dezembro", @"");  break; }
	}
	
	return r;
}

- (NSUInteger)weekDay {
	unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendar components:units fromDate:self];
	return [components weekday];
}

- (NSString *)weekDayName {
	NSString *r;
	NSUInteger w = [self weekDay];
	switch (w) {
		case WeekDayDescriptionSunday:    { r = NSLocalizedString(@"Domingo", @""); break; }
		case WeekDayDescriptionMonday:    { r = NSLocalizedString(@"Segunda-feira", @""); break; }
		case WeekDayDescriptionTuesday:   { r = NSLocalizedString(@"Terça-feira", @""); break; }
		case WeekDayDescriptionWednesday: { r = NSLocalizedString(@"Quarta-feira", @""); break; }
		case WeekDayDescriptionThursday:  { r = NSLocalizedString(@"Quinta-feira", @""); break; }
		case WeekDayDescriptionFriday:    { r = NSLocalizedString(@"Sexta-feira", @""); break; }
		case WeekDayDescriptionSaturday:  { r = NSLocalizedString(@"Sábado", @""); break; }
	}
	return r;
}

- (NSUInteger)weekDayOrdinal {
	unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendar components:units fromDate:self];
	return [components weekdayOrdinal];
}

- (NSUInteger)quarter {
	unsigned units = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit | kCFCalendarUnitQuarter;
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendar components:units fromDate:self];
	return [components quarter];
}

- (NSString *)extended {
	NSMutableString *s = [[NSMutableString alloc]init];
	[s appendFormat:@"%02d de %@ de %04d" , 
	 [self day],
	 [self monthName],
	 [self year] ];
	return s;
}

- (NSString *)extendedWithWeekDayName {
	NSMutableString *s = [[NSMutableString alloc] init];
	[s appendFormat:@"%@, %02d de %@ de %04d" , 
	 [self weekDayName], 
	 [self day],
	 [self monthName],
	 [self year] ];
	return s;
}

- (NSInteger )daysFromNow {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSDayCalendarUnit
                                               fromDate:self
                                                 toDate:[NSDate today]
                                                options:0];
    
    return components.day;
}

- (NSInteger )hoursFromNow {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSHourCalendarUnit
                                               fromDate:self
                                                 toDate:[NSDate today]
                                                options:0];
    
    return components.hour;
}

- (NSInteger )minutesFromNow {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSMinuteCalendarUnit
                                               fromDate:self
                                                 toDate:[NSDate today]
                                                options:0];
    
    return components.minute;
}

- (NSInteger )secondsFromNow {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSSecondCalendarUnit
                                               fromDate:self
                                                 toDate:[NSDate today]
                                                options:0];
    
    return components.second;
}

#pragma mark Comparing Dates

- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
	return ((components1.year == components2.year) &&
			(components1.month == components2.month) &&
			(components1.day == components2.day));
}

- (BOOL)isToday {
	return [self isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)isTomorrow {
	return [self isEqualToDateIgnoringTime:[NSDate dateTomorrow]];
}

- (BOOL)isYesterday {
	return [self isEqualToDateIgnoringTime:[NSDate dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)isSameWeekAsDate:(NSDate *)aDate {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    
	// Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
	if (components1.week != components2.week) return NO;
    
	// Must have a time interval under 1 week. Thanks @aclark
	return (abs([self timeIntervalSinceDate:aDate]) < D_WEEK);
}

- (BOOL)isThisWeek {
	return [self isSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL)isLastWeek {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_WEEK;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return [self isSameWeekAsDate:newDate];
}

- (BOOL)isSameMonthAsDate:(NSDate *)aDate {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)isThisMonth {
    return [self isSameMonthAsDate:[NSDate date]];
}

- (BOOL)isSameYearAsDate:(NSDate *)aDate {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
	return (components1.year == components2.year);
}

- (BOOL)isThisYear {
	return [self isSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	return (components1.year == (components2.year + 1));
}

- (BOOL)isLastYear {
	NSDateComponents *components1 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *components2 = [CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
	return (components1.year == (components2.year - 1));
}

- (BOOL)isEarlierThanDate:(NSDate *)aDate {
	return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *)aDate {
	return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)isInFuture {
    return ([self isLaterThanDate:[NSDate date]]);
}

- (BOOL)isInPast {
    return ([self isEarlierThanDate:[NSDate date]]);
}

#pragma mark Roles

- (BOOL)isTypicallyWeekend {
    NSDateComponents *components = [CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)isTypicallyWorkday {
    return ![self isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *)dateByAddingDays:(NSInteger)dDays {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *)dateBySubtractingDays:(NSInteger)dDays {
	return [self dateByAddingDays: (dDays * -1)];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks {
	return [self dateByAddingDays:(weeks * 7)];
}

- (NSDate *)dateBySubtractingWeeks:(NSInteger)weeks {
	return [self dateByAddingWeeks: (weeks * -1)];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
	dateComponents.month += months;
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)dateBySubtractingMonths:(NSInteger)months {
	return [self dateByAddingMonths:(months * -1)];
}

- (NSDate *)dateByAddingYears:(NSInteger)years {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSYearCalendarUnit fromDate:self];
	dateComponents.year += years;
	return [calendar dateFromComponents:dateComponents];
}

- (NSDate *)dateBySubtractingYears:(NSInteger)years {
	return [self dateByAddingYears:(years * -1)];
}

- (NSDate *)dateByAddingHours:(NSInteger)dHours {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_HOUR * dHours;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)dHours {
	return [self dateByAddingHours: (dHours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)dMinutes {
	NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	return newDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)dMinutes {
	return [self dateByAddingMinutes: (dMinutes * -1)];
}

- (NSDate *)dateAtStartOfDay {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateByLastDayOfMonth {
    NSRange daysRange = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self];
	NSDateComponents *comp = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
	[comp setDay:daysRange.length];
	NSDate *endOfMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];
	return endOfMonth;
}

- (NSDate *)firstDayOfMonth {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSDayCalendarUnit fromDate:self];
	dateComponents.day = 1;
	return [calendar dateFromComponents:dateComponents];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)aDate {
	NSDateComponents *dTime = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate toDate:self options:0];
	return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger)minutesAfterDate:(NSDate *)aDate {
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate {
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate {
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate {
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate {
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate {
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger)distanceInDaysToDate:(NSDate *)anotherDate {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return (components.day+1);
}

#pragma mark Decomposing Dates

- (NSInteger)nearestHour {
	NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
	NSDateComponents *components = [CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
	return components.hour;
}

- (NSInteger)hour {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger)minute {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger)seconds {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger)day {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger)month {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger)week {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.week;
}

- (NSInteger)weekday {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger)nthWeekday { // e.g. 2nd Tuesday of the month is 2
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger)year {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	return components.year;
}

@end

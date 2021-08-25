//
//  TypeAlias.swift
//  TypeAlias
//
//  Created by TriBQ on 8/21/21.
//

typealias VoidFunction = () -> Void
typealias OptionModelCallbackFunction = (OptionModel) -> Void
typealias OptionModelArrayCallbackFunction = ([OptionModel]) -> Void
typealias IntTupleCallbackFunction = (Int, Int) -> Void

typealias NavigationColor           = ThemeColor.NavigationColor
typealias TableViewColor            = ThemeColor.TableViewColor
typealias ButtonColor               = ThemeColor.ButtonColor
typealias CommonColor               = ThemeColor.CommonColor
typealias SleepColor                = ThemeColor.SleepColor

typealias CalendarState = CalendarViewModel.CalendarState
typealias CalendarTrigger = CalendarViewModel.CalendarTrigger

typealias CustomOptionState = CustomOptionViewModel.CustomOptionState
typealias CustomOptionTrigger = CustomOptionViewModel.CustomOptionTrigger

typealias OptionAdditionState = OptionAdditionViewModel.OptionAdditionState
typealias OptionAdditionTrigger = OptionAdditionViewModel.OptionAdditionTrigger

typealias DiaryState = DiaryViewModel.DiaryState
typealias DiaryTrigger = DiaryViewModel.DiaryTrigger

typealias ChartState = ChartViewModel.ChartState
typealias ChartTrigger = ChartViewModel.ChartTrigger

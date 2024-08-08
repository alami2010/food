"# food" 
    public static LocalDate getNextMonday(LocalDate date) {
        DayOfWeek dayOfWeek = date.getDayOfWeek();
        if (dayOfWeek == DayOfWeek.SATURDAY || dayOfWeek == DayOfWeek.SUNDAY) {
            // Calculate the difference between Sunday and Monday (1 day)
            int daysToAdd = DayOfWeek.MONDAY.getValue() - dayOfWeek.getValue();
            return date.plusDays(daysToAdd);
        } else {
            return date;
        }
    }

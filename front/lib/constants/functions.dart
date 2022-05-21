/// Formata a data [`dateTime`] recebida e retorna de acordo com o formato [`format`] desejado,
/// `format` aceita os seguintes parâmetros:
/// d = dia, m = mês, y = ano, w = dia da semana, h = horas, i = minutos, s = segundos
String datetimeToString(dynamic dateTime, {String format = "d/m/y"}) {
  String response = "";
  if (dateTime != null) {
    if (dateTime !is DateTime) {
      if (dateTime is String) {
        if (dateTime.contains("/")) {
          dateTime = dateTime.split(" ")[0].split("/").reversed.join("-");
        }
        else if (DateTime.tryParse(dateTime) != null) {
          dateTime = DateTime.parse(dateTime);
        }
      }
      else if (dateTime !is num) {
        dateTime = dateTime.toDate();
      }
    }
    if (dateTime is DateTime) {
      response = format;
      response = response.replaceAll("d", dateTime.day.toString().padLeft(2, '0'))
        .replaceAll("m", dateTime.month.toString().padLeft(2, '0'))
        .replaceAll("y", dateTime.year.toString().padLeft(4, '0'))
        .replaceAll("h", dateTime.hour.toString().padLeft(2, '0'))
        .replaceAll("i", dateTime.minute.toString().padLeft(2, '0'))
        .replaceAll("s", dateTime.second.toString().padLeft(2, '0'));
    }
  }
  return response;
}
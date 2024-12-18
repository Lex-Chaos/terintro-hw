# Домашняя работа к занятию «Введение в Terraform» - Боровик А. А.

### Подготовка

Версия Terraform

![Версия Terraform](https://github.com/Lex-Chaos/terintro/blob/main/img/Task-0-1.png)

### Задание 1

- Согласно .gitignore секретную информацию можно хранить в файлах папки **.terraform**, в файле **.tfstate** и в файле **personal.auto.tfvars**

- В поле **result** - секретное содержимое

![Версия Terraform](https://github.com/Lex-Chaos/terintro/blob/main/img/Task-1-2.png)

- Выполнение конфигурации с ошибками

![Выполнено с ошибками](https://github.com/Lex-Chaos/terintro/blob/main/img/Task-1-3.png)

Ошибки:
 пропущено имя ресурса;
 неправильное имя ресурса;

Файл конфигурации с ошибками:

![Конфигурация с ошибками](https://github.com/Lex-Chaos/terintro/blob/main/img/Task-1-4.png)

Исправленный файл конфигурации:

![Исправленная конфигурация](https://github.com/Lex-Chaos/terintro/blob/main/img/Task-1-5.png)

Выполнение конфигурации без ошибок

![Выполнено без ошибок](https://github.com/Lex-Chaos/terintro/blob/main/img/Task-1-6.png)

- Команда `terraform apply -auto-approve` автоматически применяет изменения без подтверждения пользователем. Можно случайно удалить или изменить важные ресурсы.

Можно применять:
 в втоматизированных CI/CD пайплайнах;
 в тестовых средах
 при незначительных изменениях конфигурации

![Результат docker ps](https://github.com/Lex-Chaos/terintro/blob/main/img/Task-1-7.png)

- Удаление ресурсов с помощью terraform

Файл *terraform.tfstate*:

```
{
  "version": 4,
  "terraform_version": "1.8.4",
  "serial": 44,
  "lineage": "1a42d123-dea7-cfc6-e39b-18faec52cc87",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

- docker-образ не был удалён, потому что параметр *keep_locally* был установлен в *true*

```
resource "docker_image" "nginx_latest"{
  name         = "nginx:latest"
  keep_locally = true
}
```

Выдержка из документации:

`keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.`

---

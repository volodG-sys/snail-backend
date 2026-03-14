from django.http import JsonResponse
import random
from .models import Snail  # Не забудь імпортувати модель

# Стара функція для гонок (залишаємо для фронтенду)
def start_race(request):
    snails = ["Турбо-Слизь", "Мега-Ракушка", "Шустрый Эдуард"]
    return JsonResponse({'status': 'success', 'winner': random.choice(snails)})
# Нова функція для списку равликів з фото з S3
def get_snails(request):
    snails = Snail.objects.all()
    data = []
    for s in snails:
        data.append({
            'id': s.id,
            'name': s.name,
            # photo.url автоматично згенерує Presigned URL завдяки налаштуванням S3
            'photo_url': s.photo.url if s.photo else None 
        })
    return JsonResponse({'snails': data})

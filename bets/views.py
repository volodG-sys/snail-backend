from django.http import JsonResponse
import random
def start_race(request):
    snails = ["Турбо-Слизь", "Мега-Ракушка", "Шустрый Эдуард"]
    return JsonResponse({'status': 'success', 'winner': random.choice(snails)})


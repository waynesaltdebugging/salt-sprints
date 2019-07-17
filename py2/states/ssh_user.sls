{% for name, user in pillar.get('ssh_users', {}).items() %}
add ssh user {{ name }}:
  user.present:
    - name: {{ name }}
    - password: {{ user['password'] }}
    - createhome: True
{% endfor %}

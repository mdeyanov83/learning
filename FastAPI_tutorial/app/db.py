from collections.abc import AsyncGenerator
import uuid

from sqlalchemy import Column, String, Text, DateTime, ForeignKey
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.ext.asyncio import AsyncSession, create_async_engine, async_sessionmaker
from sqlalchemy.orm import DeclarativeBase, relationship

DATABASE_URL = "sqlite+aiosqlite:///./test.db"

class Post(DeclarativeBase):
    __tablename__ = "posts"

    id = Column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)
    caption = Column(Text)
    URL = Column(String, nullable=False)
    file_type = Column(String, nullable=False)
    file_name = Column(String, nullable=False)
    created_at = Column(DateTime, nullable=False)

